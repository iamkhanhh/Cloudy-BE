import { IsEnum, IsInt, IsNotEmpty, IsOptional, IsString } from 'class-validator';
import { VisibilityEnum } from '@/enums';

export class CreateAlbumDto {
  @IsNotEmpty()
  @IsString()
  name: string;

  @IsOptional()
  @IsString()
  description?: string;

  @IsOptional()
  @IsEnum(VisibilityEnum)
  visibility?: VisibilityEnum;
}
