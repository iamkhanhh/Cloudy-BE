import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Not, In } from 'typeorm';
import { Media, AlbumMedia } from '@/entities';
import { CreateMediaDto } from './dto/create-media.dto';
import { UpdateMediaDto } from './dto/update-media.dto';
import { S3Provider } from '@/common/providers/s3.provider';
import { AlbumsService } from '../albums/albums.service';

@Injectable()
export class MediaService {
  constructor(
    @InjectRepository(Media)
    private readonly mediaRepository: Repository<Media>,
    @InjectRepository(AlbumMedia)
    private readonly albumMediaRepository: Repository<AlbumMedia>,
    private readonly s3Provider: S3Provider,
    private readonly albumsService: AlbumsService
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
      mediaAlbum.added_by = userId;

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
        file_path: this.s3Provider.getS3Url(media.file_path, media.mime_type),
      },
    };
  }

  async update(updateMediaDto: UpdateMediaDto) {
    const { id, ...rest } = updateMediaDto;

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
      where.filename = In([`%${searchTerm}%`]);
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
}
