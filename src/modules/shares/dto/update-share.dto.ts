import { PartialType } from '@nestjs/mapped-types';
import { CreateShareDto } from './create-share.dto';
import { IsInt, IsNotEmpty } from 'class-validator';

export class UpdateShareDto extends PartialType(CreateShareDto) {
  @IsNotEmpty()
  @IsInt()
  id: number;
}
