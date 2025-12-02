import { IsString, IsEmail, IsInt, IsNotEmpty } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class SendEmailWithMediaDto {
  @ApiProperty({
    description: 'Email address of the recipient',
    example: 'recipient@example.com',
  })
  @IsEmail()
  @IsNotEmpty()
  to_email: string;

  @ApiProperty({
    description: 'Subject of the email',
    example: 'Check out this media',
  })
  @IsString()
  @IsNotEmpty()
  subject: string;

  @ApiProperty({
    description: 'Body content of the email',
    example: 'Hi, I wanted to share this media with you.',
  })
  @IsString()
  @IsNotEmpty()
  body: string;

  @ApiProperty({
    description: 'ID of the media to attach',
    example: 1,
  })
  @IsInt()
  @IsNotEmpty()
  media_id: number;
}
