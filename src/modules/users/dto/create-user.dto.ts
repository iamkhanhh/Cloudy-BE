import { IsEmail, IsNotEmpty, IsOptional, IsEnum } from "class-validator";
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { UserRoleEnum } from "@/enums/user-role.enum";
import { UserStatusEnum } from "@/enums/user-status.enum";

export class CreateUserDto {
  @ApiProperty({
    description: 'User email address',
    example: 'john.doe@example.com'
  })
  @IsNotEmpty()
  @IsEmail()
  email: string;

  @ApiProperty({
    description: 'User password',
    example: 'Password123!'
  })
  @IsNotEmpty()
  password: string;

  @ApiPropertyOptional({
    description: 'User first name',
    example: 'John'
  })
  @IsOptional()
  first_name: string;

  @ApiPropertyOptional({
    description: 'User last name',
    example: 'Doe'
  })
  @IsOptional()
  last_name: string;

  @ApiPropertyOptional({
    description: 'User phone number',
    example: '+1234567890'
  })
  @IsOptional()
  phone_number: string;

  @ApiPropertyOptional({
    description: 'User bio',
    example: 'Photography enthusiast'
  })
  @IsOptional()
  bio: string;

  @ApiPropertyOptional({
    description: 'User avatar path',
    example: '/avatars/john-doe.jpg'
  })
  @IsOptional()
  avatar_path: string;

  @ApiPropertyOptional({
    description: 'User role',
    enum: UserRoleEnum,
    example: UserRoleEnum.USER
  })
  @IsOptional()
  @IsEnum(UserRoleEnum)
  role: UserRoleEnum;

  @ApiPropertyOptional({
    description: 'User status',
    enum: UserStatusEnum,
    example: UserStatusEnum.ACTIVE
  })
  @IsOptional()
  @IsEnum(UserStatusEnum)
  status: UserStatusEnum;
}
