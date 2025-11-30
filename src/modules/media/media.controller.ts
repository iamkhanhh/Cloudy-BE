import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  Request,
  ParseIntPipe,
} from '@nestjs/common';
import { MediaService } from './media.service';
import { CreateMediaDto } from './dto/create-media.dto';
import { UpdateMediaDto } from './dto/update-media.dto';

@Controller('media')
export class MediaController {
  constructor(private readonly mediaService: MediaService) {}

  @Post()
  create(
    @Body() createMediaDto: CreateMediaDto,
    @Request() req
  ) {
    return this.mediaService.create(createMediaDto, req.user?.id);
  }

  @Get()
  findAll(
    @Request() req,
    @Query('albumId', ParseIntPipe) albumId?: number,
  ) {
    return this.mediaService.findAll(req.user?.id, albumId);
  }

  @Get('search')
  search(
    @Request() req,
    @Query('searchTerm') searchTerm?: string,
  ) {
    return this.mediaService.search(req.user?.id, searchTerm);
  }

  @Get(':id')
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.mediaService.findOne(id);
  }

  @Patch(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() updateMediaDto: UpdateMediaDto,
  ) {
    return this.mediaService.update({ ...updateMediaDto, id });
  }

  @Delete(':id')
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.mediaService.remove(id);
  }
}
