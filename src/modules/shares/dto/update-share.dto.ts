import { PartialType } from '@nestjs/swagger';
import { CreateShareDto } from './create-share.dto';
import { ApiProperty } from '@nestjs/swagger';
import { IsInt, IsNotEmpty } from 'class-validator';

export class UpdateShareDto extends PartialType(CreateShareDto) {
  @ApiProperty({
    description: 'Share ID',
    example: 1
  })
  @IsNotEmpty()
  @IsInt()
  id: number;
}
