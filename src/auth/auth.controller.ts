import { Controller, Post, UseGuards, Request, Get, Body, Param, ParseIntPipe } from '@nestjs/common';
import { AuthService } from './auth.service';
import { LocalAuthGuard } from './passport/local-auth.guard';
import { JwtAuthGuard } from './passport/jwt-auth.guard';
import { Public } from '@/decorators';
import { CreateAuthDto } from './dto/create-auth.dto';


@Controller('auth')
export class AuthController {
  constructor(
    private readonly authService: AuthService,
  ) {}

  @Public()
  @Post('login')
  @UseGuards(LocalAuthGuard)
  signIn(
    @Request() req
  ) {
    return this.authService.login(req.user);
  }

  @Public()
  @Post('register')
  register(@Body() createAuthDto: CreateAuthDto) {
    return this.authService.register(createAuthDto);
  }

  @Public()
  @Post('activate-account/:id')
  activateAccount(
    @Body() activateDto: any,
    @Param('id', ParseIntPipe) id: number
  ) {
    return this.authService.activateAccount(activateDto, id);
  }
}
