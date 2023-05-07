import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { MyCassandraService } from './mycassandra.service';
import { ApiTags } from '@nestjs/swagger';

@Controller('mycassandra')
@ApiTags('mycassandra')
export class MyCassandraController {
    constructor(private readonly myCassandraService: MyCassandraService) { }

    @Get('query/:query')
    query(@Param('query') query: string) {
        return this.myCassandraService.query(query);
    }

    @Get('benchmark/:time/:query')
    benchmark(@Param('time') time: number, @Param('query') query: string,) {
        return this.myCassandraService.benchmark(time, query);
    }
}
