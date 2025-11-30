import { IsEnum, IsInt, IsNotEmpty, IsOptional, IsString, IsDateString } from 'class-validator';
import { SharePermissionEnum } from '@/enums';

export class CreateShareDto {
  @IsNotEmpty()
  @IsString()
  resource_type: string;

  @IsNotEmpty()
  @IsInt()
  resource_id: number;

  @IsNotEmpty()
  @IsInt()
  owner_id: number;

  @IsOptional()
  @IsEnum(SharePermissionEnum)
  permission?: SharePermissionEnum;

  @IsOptional()
  @IsString()
  password_hash?: string;

  @IsString()
  receiver_email: string;

  @IsOptional()
  @IsDateString()
  expires_at?: Date;
}
