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

    async benchmark(time: number, query: string) {
        const start = new Date().getTime();

        for (let i = 0; i < time; i++) {
            await this.query(query)
        }

        let elapsed = new Date().getTime() - start;
        return { elapsed: elapsed };
    }
}