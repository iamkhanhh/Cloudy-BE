import { IsEnum, IsInt, IsNotEmpty, IsOptional, IsString } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { VisibilityEnum } from '@/enums';

export class CreateAlbumDto {
  @ApiProperty({
    description: 'Album name',
    example: 'Summer Vacation 2024'
  })
  @IsNotEmpty()
  @IsString()
  name: string;

  @ApiPropertyOptional({
    description: 'Album description',
    example: 'Photos and videos from my summer vacation'
  })
  @IsOptional()
  @IsString()
  description?: string;

  @ApiPropertyOptional({
    description: 'Album visibility',
    enum: VisibilityEnum,
    example: VisibilityEnum.PUBLIC
  })
  @IsOptional()
  @IsEnum(VisibilityEnum)
  visibility?: VisibilityEnum;
}
