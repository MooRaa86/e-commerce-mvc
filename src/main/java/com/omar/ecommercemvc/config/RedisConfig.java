package com.omar.ecommercemvc.config;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public class RedisConfig {

    private static final String REDIS_HOST = "localhost";
    private static final int REDIS_PORT = 6379;

    private static JedisPool jedisPool;

    static {
        try {
            JedisPoolConfig poolConfig = new JedisPoolConfig();
            poolConfig.setMaxTotal(10);
            poolConfig.setMaxIdle(5);
            poolConfig.setMinIdle(1);

            jedisPool = new JedisPool(poolConfig, REDIS_HOST, REDIS_PORT);
            System.out.println("[REDIS] Connection pool initialized");
        } catch (Exception e) {
            System.out.println("[REDIS] Failed to initialize pool: " + e.getMessage());
        }
    }

    public static Jedis getResource() {
        return jedisPool.getResource();
    }

    public static boolean isAvailable() {
        try (Jedis jedis = jedisPool.getResource()) {
            return "PONG".equals(jedis.ping());
        } catch (Exception e) {
            System.out.println("[REDIS] Not available: " + e.getMessage());
            return false;
        }
    }
}
