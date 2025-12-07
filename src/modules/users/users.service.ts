import { BadRequestException, Injectable } from '@nestjs/common';
import { CreateAuthDto } from '@/auth/dto/create-auth.dto';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import * as dayjs from 'dayjs';
import { MailerService } from '@nestjs-modules/mailer';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Users, Media, Albums, AlbumMedia } from '@/entities';
import { UserStatusEnum, MediaTypeEnum } from '@/enums';
import { HashingPasswordProvider } from '@/common/providers/hashing-password.provider';
import { UserRoleEnum } from '@/enums/user-role.enum';

@Injectable()
export class UsersService {

  constructor(
    @InjectRepository(Users) private usersRepository: Repository<Users>,
    @InjectRepository(Media) private mediaRepository: Repository<Media>,
    @InjectRepository(Albums) private albumsRepository: Repository<Albums>,
    @InjectRepository(AlbumMedia) private albumMediaRepository: Repository<AlbumMedia>,
    private readonly mailerService: MailerService,
    private readonly hashingPasswordProvider: HashingPasswordProvider,
  ) {}

  async create(createUserDto: CreateUserDto) {
    const { email, password, first_name, last_name, phone_number, bio, avatar_path, role, status } = createUserDto;

    const isEmailExist = await this.isEMailExist(email);
    if (isEmailExist) {
      throw new BadRequestException(`${email} has been existed! Please use another email`);
    }

    const hashPassword = await this.hashingPasswordProvider.hashPasswordHelper(password);
    const newUser = new Users();

    newUser.email = email;
    newUser.password = hashPassword;
    newUser.first_name = first_name;
    newUser.last_name = last_name;
    newUser.phone_number = phone_number;
    newUser.bio = bio;
    newUser.avatar_path = avatar_path;
    newUser.role = role || UserRoleEnum.USER;
    newUser.status = status || UserStatusEnum.ACTIVE;

    const savedUser = await this.usersRepository.save(newUser);

    return {
      status: 'success',
      message: 'Create user successfully',
      data: {
        id: savedUser.id,
        email: savedUser.email,
        first_name: savedUser.first_name,
        last_name: savedUser.last_name
      }
    };
  }

  async isEMailExist(email: string) {
    const user = await this.usersRepository.exists({ where: { email: email } });
    return user ? true : false;
  }

  async findAll(current: number = 1, pageSize: number = 10) {
    const skip = (current - 1) * pageSize;

    const [results, total] = await this.usersRepository.findAndCount({
      where: { is_deleted: 0 },
      take: pageSize,
      skip: skip,
      order: { createdAt: 'DESC' },
      select: ['id', 'email', 'first_name', 'last_name', 'phone_number', 'bio', 'avatar_path', 'role', 'status', 'createdAt', 'updatedAt']
    });

    const totalPages = Math.ceil(total / pageSize);

    return {
      status: 'success',
      data: {
        results,
        pagination: {
          current,
          pageSize,
          total,
          totalPages
        }
      }
    };
  }

  async findOne(id: number) {
    const user = await this.usersRepository.findOne({
      where: { id, is_deleted: 0 },
      select: ['id', 'email', 'first_name', 'last_name', 'phone_number', 'bio', 'avatar_path', 'role', 'status', 'createdAt', 'updatedAt']
    });

    if (!user) {
      throw new BadRequestException('User not found');
    }

    const allDirectMedia = await this.mediaRepository.find({
      where: { owner_id: id, is_deleted: 0 }
    });

    const userAlbums = await this.albumsRepository.find({
      where: { owner_id: id, is_deleted: 0 }
    });

    let size_total = await this.getUserStorage(id);

    return {
      status: 'success',
      data: {
        ...user,
        media_count: allDirectMedia.length,
        albums_count: userAlbums.length,
        total: size_total.data.TOTAL
      }
    };
  }

  async findByEmail(email: string) {
    return await this.usersRepository.findOne({ where: { email } });
  }
  async update(userId: number, updateUserDto: UpdateUserDto) {
    const { password, ...rest } = updateUserDto;

    // Check if user exists
    const existingUser = await this.usersRepository.findOne({ where: { id: userId, is_deleted: 0 } });
    if (!existingUser) {
      throw new BadRequestException('User not found');
    }

    // Check if email already exists for another user
    if (rest.email && rest.email !== existingUser.email) {
      const emailExists = await this.isEMailExist(rest.email);
      if (emailExists) {
        throw new BadRequestException(`${rest.email} has been existed! Please use another email`);
      }
    }

    const updateData: any = { ...rest };

    if (password) {
      updateData.password = await this.hashingPasswordProvider.hashPasswordHelper(password);
    }

    await this.usersRepository.update({ id: userId }, updateData);

    return {
      status: 'success',
      message: 'Update user successfully'
    };
  }

  async remove(id: number) {
    await this.usersRepository.update({ id }, { is_deleted: 1 });
    return {
      status: 'success',
      message: 'Delete user successfully'
    }
  }

  /**
   * Generate a random 6-digit activation code
   */
  private generateActivationCode(): string {
    return Math.floor(100000 + Math.random() * 900000).toString();
  }

  async register(createAuthDto: CreateAuthDto) {
    const { email, password, first_name, last_name, phone_number, bio } = createAuthDto;

    const isEmailExist = await this.isEMailExist(email);
    if (isEmailExist) {
      throw new BadRequestException(`${email} has been existed! Please use another email!`)
    }

    const hashPassword = await this.hashingPasswordProvider.hashPasswordHelper(password);
    const codeId = this.generateActivationCode();
    const newUser = new Users();

    newUser.email = email;
    newUser.password = hashPassword;
    newUser.first_name = first_name;
    newUser.last_name = last_name;
    newUser.phone_number = phone_number;
    newUser.bio = bio;
    newUser.role = UserRoleEnum.USER;
    newUser.status = UserStatusEnum.PENDING;
    newUser.codeId = codeId;
    newUser.codeExpired = dayjs().add(30, 'minutes').toDate();
    const savedUser = await this.usersRepository.save(newUser);

    this.mailerService
      .sendMail({
        to: savedUser.email,
        subject: 'Activate your account',
        template: "register",
        context: {
          name: savedUser.first_name && savedUser.last_name ? `${savedUser.first_name} ${savedUser.last_name}` : savedUser.email,
          activationCode: codeId
        }
      })

    return {
      status: 'success',
      message: 'Created an account successfully!',
      data: {
        id: savedUser.id,
        email: savedUser.email
      }
    };
  }

  async activateAccount(code: string, id: number) {
    const user = await this.usersRepository.findOne({ where: { id } });
    if (!user) {
      throw new BadRequestException('This account is not exist!')
    }

    const isCodeValid = new Date() < user.codeExpired;
    if (isCodeValid) {
      if (code == user.codeId) {
        await this.usersRepository.update({ id }, { status: UserStatusEnum.ACTIVE });
        return {
          status: 'success',
          message: 'Your account has been active!!'
        }
      } else {
        throw new BadRequestException('Code active is not correct!')
      }
    } else {
      throw new BadRequestException('Code active has been expired! Please get another code!')
    }
  }

  async resendActivationCode(email: string) {
    const user = await this.usersRepository.findOne({ where: { email } });
    if (!user) {
      throw new BadRequestException('This account is not exist!')
    }

    if (user.status === UserStatusEnum.ACTIVE) {
      throw new BadRequestException('This account is already active!')
    }

    const newCode = this.generateActivationCode();
    const newExpiry = dayjs().add(30, 'minutes').toDate();

    await this.usersRepository.update({ id: user.id }, {
      codeId: newCode,
      codeExpired: newExpiry
    });

    this.mailerService
      .sendMail({
        to: user.email,
        subject: 'Activate your account - New Code',
        template: "register",
        context: {
          name: user.first_name && user.last_name ? `${user.first_name} ${user.last_name}` : user.email,
          activationCode: newCode
        }
      })

    return {
      status: 'success',
      message: 'A new activation code has been sent to your email!',
      data: {
        id: user.id,
        email: user.email
      }
    };
  }

  async getUserStorage(userId: number) {
    const user = await this.usersRepository.findOne({ where: { id: userId, is_deleted: 0 } });
    if (!user) {
      throw new BadRequestException('User not found');
    }

    const allDirectMedia = await this.mediaRepository.find({
      where: { owner_id: userId, is_deleted: 0 },
      select: ['type', 'size']
    });

    const userAlbums = await this.albumsRepository.find({
      where: { owner_id: userId, is_deleted: 0 },
      select: ['id']
    });

    const albumIds = userAlbums.map(album => album.id);

    let allAlbumMedia = [];
    if (albumIds.length > 0) {
      const albumMediaLinks = await this.albumMediaRepository.find({
        where: albumIds.map(albumId => ({ album_id: albumId })),
        select: ['media_id']
      });

      const mediaIds = albumMediaLinks.map(link => link.media_id);

      if (mediaIds.length > 0) {
        allAlbumMedia = await this.mediaRepository.find({
          where: mediaIds.map(mediaId => ({ id: mediaId, is_deleted: 0 })),
          select: ['type', 'size']
        });
      }
    }

    const storageByCategory: any = {
      IMAGE: 0,
      VIDEO: 0,
    };

    allDirectMedia.forEach(media => {
      const size = media.size || 0;
      storageByCategory[media.type] = (storageByCategory[media.type] || 0) + size;
    });

    allAlbumMedia.forEach(media => {
      const size = media.size || 0;
      storageByCategory[media.type] = (storageByCategory[media.type] || 0) + size;
    });

    const convertToGB = (bytes: number) => {
      return parseFloat((bytes / (1024 * 1024 * 1024)).toFixed(4));
    };

    const storageInGB = {
      IMAGE: convertToGB(storageByCategory.IMAGE),
      VIDEO: convertToGB(storageByCategory.VIDEO),
      TOTAL: convertToGB(storageByCategory.IMAGE + storageByCategory.VIDEO),
    };

    return {
      status: 'success',
      data: storageInGB
    };
  }
}
