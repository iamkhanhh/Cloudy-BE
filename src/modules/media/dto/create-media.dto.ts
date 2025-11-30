import { IsEnum, IsInt, IsNotEmpty, IsOptional, IsString } from 'class-validator';
import { MediaTypeEnum, VisibilityEnum, ProcessingStatusEnum } from '@/enums';

export class CreateMediaDto {
  @IsNotEmpty()
  @IsEnum(MediaTypeEnum)
  type: MediaTypeEnum;

  @IsNotEmpty()
  @IsString()
  mime_type: string;

  @IsNotEmpty()
  @IsString()
  filename: string;

  @IsOptional()
  @IsInt()
  size?: number;

  @IsOptional()
  @IsInt()
  duration_ms?: number;

  @IsOptional()
  @IsEnum(VisibilityEnum)
  visibility?: VisibilityEnum;

  @IsOptional()
  @IsEnum(ProcessingStatusEnum)
  processing_status?: ProcessingStatusEnum;

  @IsOptional()
  @IsString()
  caption?: string;

  @IsOptional()
  @IsString()
  file_path?: string;

  @IsOptional()
  @IsInt()
  albumsId?: number;
}
