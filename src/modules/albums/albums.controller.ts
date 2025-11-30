import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  ParseIntPipe,
  Request
} from '@nestjs/common';
import { AlbumsService } from './albums.service';
import { CreateAlbumDto } from './dto/create-album.dto';
import { UpdateAlbumDto } from './dto/update-album.dto';

@Controller('albums')
export class AlbumsController {
  constructor(private readonly albumsService: AlbumsService) {}

  @Post()
  create(
    @Body() createAlbumDto: CreateAlbumDto,
    @Request() req
  ) {
    return this.albumsService.create(createAlbumDto, req.user?.id);
  }

  @Get()
  findAll(@Request() req) {
    return this.albumsService.findAll(req.user?.id);
  }

  @Get(':id')
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.albumsService.findOne(id);
  }

  @Patch(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() updateAlbumDto: UpdateAlbumDto,
  ) {
    return this.albumsService.update({ ...updateAlbumDto, id });
  }

  @Delete(':id')
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.albumsService.remove(id);
  }
}
