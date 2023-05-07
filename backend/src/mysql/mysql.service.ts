import { Inject, Injectable } from '@nestjs/common';
import { InjectDataSource } from '@nestjs/typeorm';
import { DataSource } from 'typeorm';

@Injectable()
export class MySqlService {
    constructor(
        @InjectDataSource() private dataSource: DataSource
    ) { }

    async query(query: string) {
        const result = await this.dataSource.query(query)
        return result;
    }
}