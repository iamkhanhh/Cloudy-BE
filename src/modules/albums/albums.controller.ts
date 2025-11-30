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
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { AlbumsService } from './albums.service';
import { CreateAlbumDto } from './dto/create-album.dto';
import { UpdateAlbumDto } from './dto/update-album.dto';

@ApiTags('albums')
@ApiBearerAuth('JWT-auth')
@Controller('albums')
export class AlbumsController {
  constructor(private readonly albumsService: AlbumsService) {}

  @Post()
  @ApiOperation({ summary: 'Create album', description: 'Create a new album' })
  @ApiResponse({ status: 201, description: 'Album created successfully' })
  @ApiResponse({ status: 400, description: 'Invalid input' })
  create(
    @Body() createAlbumDto: CreateAlbumDto,
    @Request() req
  ) {
    return this.albumsService.create(createAlbumDto, req.user?.id);
  }

  @Get()
  @ApiOperation({ summary: 'Get all albums', description: 'Retrieve all albums for the current user' })
  @ApiResponse({ status: 200, description: 'Albums retrieved successfully' })
  findAll(@Request() req) {
    return this.albumsService.findAll(req.user?.id);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get album by ID', description: 'Retrieve a specific album by its ID' })
  @ApiResponse({ status: 200, description: 'Album found' })
  @ApiResponse({ status: 404, description: 'Album not found' })
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.albumsService.findOne(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update album', description: 'Update album information' })
  @ApiResponse({ status: 200, description: 'Album updated successfully' })
  @ApiResponse({ status: 404, description: 'Album not found' })
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() updateAlbumDto: UpdateAlbumDto,
  ) {
    return this.albumsService.update({ ...updateAlbumDto, id });
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete album', description: 'Soft delete an album' })
  @ApiResponse({ status: 200, description: 'Album deleted successfully' })
  @ApiResponse({ status: 404, description: 'Album not found' })
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.albumsService.remove(id);
  }
}
