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
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth, ApiQuery } from '@nestjs/swagger';
import { MediaService } from './media.service';
import { CreateMediaDto } from './dto/create-media.dto';
import { UpdateMediaDto } from './dto/update-media.dto';

@ApiTags('media')
@ApiBearerAuth('JWT-auth')
@Controller('media')
export class MediaController {
  constructor(private readonly mediaService: MediaService) {}

  @Post()
  @ApiOperation({ summary: 'Create media', description: 'Upload and create a new media item' })
  @ApiResponse({ status: 201, description: 'Media created successfully' })
  @ApiResponse({ status: 400, description: 'Invalid input' })
  create(
    @Body() createMediaDto: CreateMediaDto,
    @Request() req
  ) {
    return this.mediaService.create(createMediaDto, req.user?.id);
  }

  @Get()
  @ApiOperation({ summary: 'Get all media', description: 'Retrieve all media items for the current user' })
  @ApiQuery({ name: 'albumId', required: false, description: 'Filter by album ID', example: 1 })
  @ApiResponse({ status: 200, description: 'Media items retrieved successfully' })
  findAll(
    @Request() req,
    @Query('albumId', new ParseIntPipe({ optional: true })) albumId?: number,
  ) {
    return this.mediaService.findAll(req.user?.id, albumId);
  }

  @Get('search')
  @ApiOperation({ summary: 'Search media', description: 'Search media items by caption or filename' })
  @ApiQuery({ name: 'searchTerm', required: false, description: 'Search term', example: 'sunset' })
  @ApiResponse({ status: 200, description: 'Search results retrieved successfully' })
  search(
    @Request() req,
    @Query('searchTerm') searchTerm?: string,
  ) {
    return this.mediaService.search(req.user?.id, searchTerm);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get media by ID', description: 'Retrieve a specific media item by its ID' })
  @ApiResponse({ status: 200, description: 'Media item found' })
  @ApiResponse({ status: 404, description: 'Media item not found' })
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.mediaService.findOne(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update media', description: 'Update media item information' })
  @ApiResponse({ status: 200, description: 'Media updated successfully' })
  @ApiResponse({ status: 404, description: 'Media item not found' })
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() updateMediaDto: UpdateMediaDto,
  ) {
    return this.mediaService.update({ ...updateMediaDto, id });
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete media', description: 'Soft delete a media item' })
  @ApiResponse({ status: 200, description: 'Media deleted successfully' })
  @ApiResponse({ status: 404, description: 'Media item not found' })
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.mediaService.remove(id);
  }
}
