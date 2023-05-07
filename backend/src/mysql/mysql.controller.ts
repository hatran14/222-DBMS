import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { MySqlService } from './mysql.service';
import { ApiTags } from '@nestjs/swagger';

@Controller('mysql')
@ApiTags('mysql')
export class MySqlController {
    constructor(private readonly mySqlService: MySqlService) { }

    @Get('query/:query')
    query(@Param('query') query: string) {
        return this.mySqlService.query(query);
    }

    // @Get()
    // findAll() {
    //     return this.mySqlService.query('SELECT * FROM product');
    // }


}
