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
}