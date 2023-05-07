import { Inject, Injectable } from '@nestjs/common';
import { InjectCassandra } from '@mich4l/nestjs-cassandra';
import { Client } from 'cassandra-driver';

@Injectable()
export class MyCassandraService {
    constructor(
        @InjectCassandra()
        private readonly dbClient: Client,
    ) { }

    async query(query: string) {
        const result = await this.dbClient.execute(query);
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