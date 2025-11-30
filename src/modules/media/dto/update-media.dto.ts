import { PartialType } from '@nestjs/mapped-types';
import { CreateMediaDto } from './create-media.dto';
import { IsInt, IsNotEmpty } from 'class-validator';

export class UpdateMediaDto extends PartialType(CreateMediaDto) {
  @IsNotEmpty()
  @IsInt()
  id: number;
}
