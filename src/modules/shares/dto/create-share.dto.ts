import { IsEnum, IsInt, IsNotEmpty, IsOptional, IsString, IsDateString } from 'class-validator';
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { ResourceTypeEnum, SharePermissionEnum } from '@/enums';

export class CreateShareDto {
  @ApiProperty({
    description: 'Type of resource to share',
    enum: ResourceTypeEnum,
    example: ResourceTypeEnum.MEDIA
  })
  @IsNotEmpty()
  @IsEnum(ResourceTypeEnum)
  resource_type: ResourceTypeEnum;

  @ApiProperty({
    description: 'ID of the resource to share',
    example: 1
  })
  @IsNotEmpty()
  @IsInt()
  resource_id: number;

  @ApiPropertyOptional({
    description: 'Permission level for the share',
    enum: SharePermissionEnum,
    example: SharePermissionEnum.VIEW
  })
  @IsOptional()
  @IsEnum(SharePermissionEnum)
  permission?: SharePermissionEnum;

  @ApiProperty({
    description: 'Email of the user to share with',
    example: 'friend@example.com'
  })
  @IsString()
  receiver_email: string;
}
