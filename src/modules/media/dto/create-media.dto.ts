import { IsEnum, IsInt, IsNotEmpty, IsOptional, IsString } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { MediaTypeEnum, VisibilityEnum, ProcessingStatusEnum } from '@/enums';

export class CreateMediaDto {
  @ApiProperty({
    description: 'Media type',
    enum: MediaTypeEnum,
    example: MediaTypeEnum.IMAGE
  })
  @IsNotEmpty()
  @IsEnum(MediaTypeEnum)
  type: MediaTypeEnum;

  @ApiProperty({
    description: 'MIME type of the media file',
    example: 'image/jpeg'
  })
  @IsNotEmpty()
  @IsString()
  mime_type: string;

  @ApiProperty({
    description: 'Filename of the media',
    example: 'sunset-beach.jpg'
  })
  @IsNotEmpty()
  @IsString()
  filename: string;

  @ApiPropertyOptional({
    description: 'File size in bytes',
    example: 2048576
  })
  @IsOptional()
  @IsInt()
  size?: number;

  @ApiPropertyOptional({
    description: 'Duration in milliseconds (for videos)',
    example: 45000
  })
  @IsOptional()
  @IsInt()
  duration_ms?: number;

  @ApiPropertyOptional({
    description: 'Media visibility',
    enum: VisibilityEnum,
    example: VisibilityEnum.PUBLIC
  })
  @IsOptional()
  @IsEnum(VisibilityEnum)
  visibility?: VisibilityEnum;

  @ApiPropertyOptional({
    description: 'Processing status',
    enum: ProcessingStatusEnum,
    example: ProcessingStatusEnum.DONE
  })
  @IsOptional()
  @IsEnum(ProcessingStatusEnum)
  processing_status?: ProcessingStatusEnum;

  @ApiPropertyOptional({
    description: 'Media caption',
    example: 'Beautiful sunset at the beach'
  })
  @IsOptional()
  @IsString()
  caption?: string;

  @ApiPropertyOptional({
    description: 'File path on server',
    example: '/uploads/1/sunset-beach.jpg'
  })
  @IsOptional()
  @IsString()
  file_path?: string;

  @ApiPropertyOptional({
    description: 'Album ID to add this media to',
    example: 1
  })
  @IsOptional()
  @IsInt()
  albumsId?: number;
}
