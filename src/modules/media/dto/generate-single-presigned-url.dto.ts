import { IsNotEmpty, IsNumber, IsOptional, IsString } from "class-validator";

export class GenerateSinglePresignedUrl {
    @IsNotEmpty()
    @IsString()
    fileName: string

    @IsOptional()
    @IsNumber()
    albumId: number
}