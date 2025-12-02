import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Not, In, Like } from 'typeorm';
import { Media, AlbumMedia, EmailLogs, EmailAttachments } from '@/entities';
import { CreateMediaDto } from './dto/create-media.dto';
import { UpdateMediaDto } from './dto/update-media.dto';
import { SendEmailWithMediaDto } from './dto/send-email-with-media.dto';
import { S3Provider } from '@/common/providers/s3.provider';
import { AlbumsService } from '../albums/albums.service';
import { MailerService } from '@nestjs-modules/mailer';
import { EmailStatusEnum } from '@/enums';

@Injectable()
export class MediaService {
  constructor(
    @InjectRepository(Media)
    private readonly mediaRepository: Repository<Media>,
    @InjectRepository(AlbumMedia)
    private readonly albumMediaRepository: Repository<AlbumMedia>,
    @InjectRepository(EmailLogs)
    private readonly emailLogsRepository: Repository<EmailLogs>,
    @InjectRepository(EmailAttachments)
    private readonly emailAttachmentsRepository: Repository<EmailAttachments>,
    private readonly s3Provider: S3Provider,
    private readonly albumsService: AlbumsService,
    private readonly mailerService: MailerService
  ) {}

  async create(createMediaDto: CreateMediaDto, userId: number) {
    const newMedia = new Media();

    newMedia.owner_id = userId;
    newMedia.type = createMediaDto.type;
    newMedia.mime_type = createMediaDto.mime_type;
    newMedia.filename = createMediaDto.filename;
    newMedia.size = createMediaDto.size;
    if (createMediaDto.duration_ms) newMedia.duration_ms = createMediaDto.duration_ms;
    if (createMediaDto.visibility) newMedia.visibility = createMediaDto.visibility;
    newMedia.caption = createMediaDto.caption;
    newMedia.file_path = createMediaDto.file_path;

    const savedMedia = await this.mediaRepository.save(newMedia);

    if (createMediaDto.albumsId) {
      const album = await this.albumsService.findOne(createMediaDto.albumsId);

      const mediaAlbum = new AlbumMedia();
      mediaAlbum.album_id = album.data.id;
      mediaAlbum.media_id = savedMedia.id;

      await this.albumMediaRepository.save(mediaAlbum);
    }

    return {
      status: 'success',
      message: 'Media created successfully',
      data: savedMedia,
    };
  }

  async findAll(owner_id?: number, albumId?: number) {
    const where: any = { is_deleted: 0 };

    if (owner_id) {
      where.owner_id = owner_id;
    }

    if (albumId) {
      const mediaInAlbum = await this.albumMediaRepository.find({
        where: {
          album_id: albumId
        },
        select: ['media_id'],
      });
      const mediaIds = mediaInAlbum.map(am => am.media_id);
      where.id = In(mediaIds);
    }

    let results = await this.mediaRepository.find({
      where,
      order: { createdAt: 'DESC' },
    });

    const mediaWithUrls = await Promise.all(
      results.map(async (media) => ({
        ...media,
        file_path: await this.s3Provider.getS3Url(media.file_path, media.mime_type),
      }))
    );

    return {
      status: 'success',
      message: 'Media retrieved successfully',
      data: mediaWithUrls,
    };
  }

  async findOne(id: number) {
    const media = await this.mediaRepository.findOne({
      where: { id, is_deleted: 0 },
    });

    if (!media) {
      throw new BadRequestException('Media not found');
    }

    return {
      status: 'success',
      data: {
        ...media,
        file_path: await this.s3Provider.getS3Url(media.file_path, media.mime_type),
      },
    };
  }

  async generateSinglePresignedUrl(fileName: string, user_id: number, albumId: number) {
    let uploadName = this.s3Provider.generateFileName(fileName);
    let filePathUpload = albumId != null ? `${user_id}/${albumId}/${uploadName}` : `${user_id}/${uploadName}`;
    let data = await this.s3Provider.generateSinglePresignedUrl(filePathUpload)
    return {
      status: 'success',
      message: 'Generate single presigned url successfully',
      data: {
        url: data.url,
        uploadName,
        contentType: data.contentType
      }
    }
  }

  async download(user_id: number, mediaId: number) {
    let existingMedia = await this.mediaRepository.findOne({
      where: { id: mediaId, is_deleted: 0 },
    });

    if (!existingMedia) {
      throw new BadRequestException('Media not found');
    }

    return {
      status: "success",
      message: "Get download link succssfully",
      data: {
        url: await this.s3Provider.getS3Url(existingMedia.filename, existingMedia.mime_type)
      }
    }
  }

  async update(updateMediaDto: UpdateMediaDto, id: number) {
    const { ...rest } = updateMediaDto;

    const existingMedia = await this.mediaRepository.findOne({
      where: { id, is_deleted: 0 },
    });

    if (!existingMedia) {
      throw new BadRequestException('Media not found');
    }

    await this.mediaRepository.update({ id }, rest);

    return {
      status: 'success',
      message: 'Media updated successfully',
    };
  }

  async remove(id: number) {
    const existingMedia = await this.mediaRepository.findOne({
      where: { id, is_deleted: 0 },
    });

    if (!existingMedia) {
      throw new BadRequestException('Media not found');
    }

    await this.mediaRepository.update({ id }, { is_deleted: 1 });

    return {
      status: 'success',
      message: 'Media deleted successfully',
    };
  }

  async search(owner_id: number, searchTerm?: string) {
    const where: any = {
      is_deleted: 0,
      owner_id,
    };

    if (searchTerm) {
      where.filename = Like(`%${searchTerm}%`);
    }

    const dataMedia = await this.mediaRepository.find({
      where,
      order: { createdAt: 'DESC' },
    });

    const mediaWithUrls = await Promise.all(
      dataMedia.map(async (media) => ({
        ...media,
        file_path: await this.s3Provider.getS3Url(media.file_path, media.mime_type),
      }))
    );

    const dataAlbums = await this.albumsService.search(owner_id, searchTerm);

    return {
      status: 'success',
      data: mediaWithUrls,
      albums: dataAlbums.data,
    };
  }

  async sendEmailWithMedia(sendEmailDto: SendEmailWithMediaDto, userId: number) {
    const { to_email, subject, body, media_id } = sendEmailDto;

    const media = await this.mediaRepository.findOne({
      where: { id: media_id, is_deleted: 0 },
    });

    if (!media) {
      throw new BadRequestException('Media not found');
    }

    if (media.owner_id !== userId) {
      throw new BadRequestException('You do not have permission to share this media');
    }

    const emailLog = new EmailLogs();
    emailLog.sender_id = userId;
    emailLog.to_email = to_email;
    emailLog.subject = subject;
    emailLog.body = body;
    emailLog.status = EmailStatusEnum.QUEUED;

    try {
      const fileBuffer = await this.s3Provider.getFileFromS3(media.file_path);

      await this.mailerService.sendMail({
        to: to_email,
        subject: subject,
        html: body,
        attachments: [
          {
            filename: media.filename,
            content: fileBuffer,
            contentType: media.mime_type,
          },
        ],
      });

      emailLog.status = EmailStatusEnum.SENT;
      const savedEmailLog = await this.emailLogsRepository.save(emailLog);

      const emailAttachment = new EmailAttachments();
      emailAttachment.email_id = savedEmailLog.id;
      emailAttachment.media_id = media.id;
      await this.emailAttachmentsRepository.save(emailAttachment);

      return {
        status: 'success',
        message: 'Email sent successfully',
        data: {
          email_id: savedEmailLog.id,
          to: to_email,
          subject: subject,
        },
      };
    } catch (error) {
      emailLog.status = EmailStatusEnum.FAILED;
      emailLog.error_message = error.message;
      await this.emailLogsRepository.save(emailLog);

      throw new BadRequestException(`Failed to send email: ${error.message}`);
    }
  }
}
