import { PartialType } from '@nestjs/swagger';
import { CreateMediaDto } from './create-media.dto';
import { ApiProperty } from '@nestjs/swagger';
import { IsInt, IsNotEmpty } from 'class-validator';

export class UpdateMediaDto extends PartialType(CreateMediaDto) {
  @ApiProperty({
    description: 'Media ID',
    example: 1
  })
  @IsNotEmpty()
  @IsInt()
  id: number;
}
