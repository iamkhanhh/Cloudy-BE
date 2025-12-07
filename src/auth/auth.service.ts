
import { UsersService } from '@/modules/users/users.service';
import { BadRequestException, Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { CreateAuthDto } from './dto/create-auth.dto';
import { ChangePasswordDto } from './dto/change-password.dto';
import { UserStatusEnum } from '@/enums';
import { HashingPasswordProvider } from '@/common/providers/hashing-password.provider';

@Injectable()
export class AuthService {
  constructor(
    private usersService: UsersService,
    private jwtService: JwtService,
    private readonly hashingPasswordProvider: HashingPasswordProvider,
  ) {}

  async login(user: any) {
    const payload = { email: user.email, id: user.id , role: user.role, first_name: user.first_name, last_name: user.last_name};
    return {
      access_token: await this.jwtService.sign(payload),
    };
  }

  async validateUser(email: string, pass: string): Promise<any> {
    const user = await this.usersService.findByEmail(email);

    if (!user) {
      return null
    }

    if (user.status == UserStatusEnum.PENDING) {
      throw new BadRequestException('Your account is not active!')
    } else if (user.status == UserStatusEnum.DELETED) {
      throw new BadRequestException('Your account is deleted! Please contact to admin')
    } else if (user.status == UserStatusEnum.DISABLED) {
      throw new BadRequestException('Your account is disabled! Please contact to admin')
    }

    const isValidPassword = await this.hashingPasswordProvider.comparePasswordHelper(pass, user.password);

    if (!isValidPassword) {
      throw new BadRequestException('The password did not match!')
    }

    return user
  }

  async register(createAuthDto: CreateAuthDto) {
    return await this.usersService.register(createAuthDto);
  }

  async activateAccount(activateDto: any, id: number) {
    return await this.usersService.activateAccount(activateDto.code, id);
  }

  async getCurrentUser(userId: number) {
    return await this.usersService.findOne(userId);
  }

  async changePassword(userId: number, changePasswordDto: ChangePasswordDto) {
    const { currentPassword, newPassword } = changePasswordDto;

    const user = await this.usersService.findOne(userId);
    if (!user) {
      throw new BadRequestException('User not found');
    }

    const userWithPassword = await this.usersService.findByEmail(user.data.email);

    const isValidPassword = await this.hashingPasswordProvider.comparePasswordHelper(
      currentPassword,
      userWithPassword.password,
    );

    if (!isValidPassword) {
      throw new BadRequestException('Current password is incorrect');
    }

    const isSamePassword = await this.hashingPasswordProvider.comparePasswordHelper(
      newPassword,
      userWithPassword.password,
    );

    if (isSamePassword) {
      throw new BadRequestException('New password must be different from current password');
    }

    await this.usersService.update(userId, {
      password: newPassword,
    } as any);

    return {
      status: 'success',
      message: 'Password changed successfully',
    };
  }

  async resendActivationCode(email: string) {
    return await this.usersService.resendActivationCode(email);
  }
}