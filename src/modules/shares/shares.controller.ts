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
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { SharesService } from './shares.service';
import { CreateShareDto } from './dto/create-share.dto';
import { UpdateShareDto } from './dto/update-share.dto';

@ApiTags('shares')
@ApiBearerAuth('JWT-auth')
@Controller('shares')
export class SharesController {
  constructor(private readonly sharesService: SharesService) {}

  @Post()
  @ApiOperation({ summary: 'Create share', description: 'Share a media item or album with another user' })
  @ApiResponse({ status: 201, description: 'Share created successfully' })
  @ApiResponse({ status: 400, description: 'Invalid input' })
  create(
    @Body() createShareDto: CreateShareDto,
    @Request() req
  ) {
    return this.sharesService.create(createShareDto, req.user?.id);
  }

  @Get()
  @ApiOperation({ summary: 'Get all shares', description: 'Retrieve all shares created by the current user' })
  @ApiResponse({ status: 200, description: 'Shares retrieved successfully' })
  findAll(@Request() req) {
    return this.sharesService.findAll(req.user?.id);
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get share by ID', description: 'Retrieve a specific share by its ID' })
  @ApiResponse({ status: 200, description: 'Share found' })
  @ApiResponse({ status: 404, description: 'Share not found' })
  findOne(@Param('id', ParseIntPipe) id: number) {
    return this.sharesService.findOne(id);
  }

  @Patch(':id')
  @ApiOperation({ summary: 'Update share', description: 'Update share information' })
  @ApiResponse({ status: 200, description: 'Share updated successfully' })
  @ApiResponse({ status: 404, description: 'Share not found' })
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() updateShareDto: UpdateShareDto,
  ) {
    return this.sharesService.update({ ...updateShareDto, id });
  }

  @Delete(':id')
  @ApiOperation({ summary: 'Delete share', description: 'Soft delete a share' })
  @ApiResponse({ status: 200, description: 'Share deleted successfully' })
  @ApiResponse({ status: 404, description: 'Share not found' })
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.sharesService.remove(id);
  }
}
