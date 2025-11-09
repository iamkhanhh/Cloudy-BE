import { IsEmail, IsNotEmpty, IsOptional, IsEnum } from "class-validator";
import { UserRoleEnum } from "@/enums/user-role.enum";
import { UserStatusEnum } from "@/enums/user-status.enum";

export class CreateUserDto {
  @IsNotEmpty()
  @IsEmail()
  email: string;

  @IsNotEmpty()
  password: string;

  @IsOptional()
  first_name: string;

  @IsOptional()
  last_name: string;

  @IsOptional()
  phone_number: string;

  @IsOptional()
  bio: string;

  @IsOptional()
  avatar_path: string;

  @IsOptional()
  @IsEnum(UserRoleEnum)
  role: UserRoleEnum;

  @IsOptional()
  @IsEnum(UserStatusEnum)
  status: UserStatusEnum;
}
