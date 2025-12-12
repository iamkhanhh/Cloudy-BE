import { IsNotEmpty, IsString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateReportDto {
  @ApiProperty({
    description: 'Report title',
    example: 'Cannot upload files',
  })
  @IsNotEmpty()
  @IsString()
  title: string;

  @ApiProperty({
    description: 'Report details/description',
    example: 'I am having trouble uploading files. The upload button is not working...',
  })
  @IsNotEmpty()
  @IsString()
  details: string;
}
