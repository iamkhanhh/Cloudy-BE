import { IsNotEmpty, IsOptional, IsString, Matches, MinLength } from "class-validator"
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';

export class CreateAuthDto {
  @ApiProperty({
    description: 'User email address',
    example: 'user@example.com'
  })
  @IsNotEmpty()
  email: string

  @ApiProperty({
    description: 'User password (minimum 8 characters, at least one letter, one number and one special character)',
    example: 'Password123!',
    minLength: 8
  })
  @IsNotEmpty()
  @IsString()
  @MinLength(5)
  @Matches(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/, {
      message: 'Password must be minimum five characters, at least one letter, one number and one special character',
  })
  password: string

  @ApiPropertyOptional({
    description: 'User first name',
    example: 'John'
  })
  @IsOptional()
  @IsString()
  first_name: string

  @ApiPropertyOptional({
    description: 'User last name',
    example: 'Doe'
  })
  @IsOptional()
  @IsString()
  last_name: string

  @ApiPropertyOptional({
    description: 'User address',
    example: '123 Main St, New York, NY'
  })
  @IsOptional()
  @IsString()
  address: string

  @ApiPropertyOptional({
    description: 'User bio',
    example: 'Photography enthusiast and nature lover'
  })
  @IsOptional()
  @IsString()
  bio: string

  @ApiPropertyOptional({
    description: 'User phone number',
    example: '+1234567890'
  })
  @IsOptional()
  @IsString()
  phone_number: string
}
