import { PartialType } from '@nestjs/swagger';
import { CreateAlbumDto } from './create-album.dto';
import { ApiProperty } from '@nestjs/swagger';
import { IsInt, IsNotEmpty } from 'class-validator';

export class UpdateAlbumDto extends PartialType(CreateAlbumDto) {
}
