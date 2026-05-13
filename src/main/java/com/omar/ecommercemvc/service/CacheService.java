package com.omar.ecommercemvc.service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.omar.ecommercemvc.config.RedisConfig;
import redis.clients.jedis.Jedis;

import java.lang.reflect.Type;
import java.util.List;

public class CacheService {

    private static final Gson gson = new Gson();
    private static final int DEFAULT_TTL_SECONDS = 300;

    public void set(String key, Object value) {
        if (!RedisConfig.isAvailable()) {
            System.out.println(" Redis unavailable, skipping set for key: " + key);
            return;
        }

        try (Jedis jedis = RedisConfig.getResource()) {
            String json = gson.toJson(value);
            jedis.setex(key, DEFAULT_TTL_SECONDS, json);
        } catch (Exception e) {
            System.out.println(" Set error for key " + key + ": " + e.getMessage());
        }
    }

    public <T> T get(String key, Class<T> type) {
        if (!RedisConfig.isAvailable()) {
            return null;
        }

        try (Jedis jedis = RedisConfig.getResource()) {
            String json = jedis.get(key);
            if (json != null) {
                return gson.fromJson(json, type);
            }
        } catch (Exception e) {
            System.out.println(" Get error for key " + key + ": " + e.getMessage());
        }

        return null;
    }

    public <T> List<T> getList(String key, Class<T> type) {
        if (!RedisConfig.isAvailable()) {
            return null;
        }

        try (Jedis jedis = RedisConfig.getResource()) {
            String json = jedis.get(key);
            if (json != null) {
                Type listType = TypeToken.getParameterized(List.class, type).getType();
                return gson.fromJson(json, listType);
            }
        } catch (Exception e) {
            System.out.println(" GetList error for key " + key + ": " + e.getMessage());
        }

        return null;
    }

    public void delete(String key) {
        if (!RedisConfig.isAvailable()) {
            return;
        }

        try (Jedis jedis = RedisConfig.getResource()) {
            jedis.del(key);
        } catch (Exception e) {
            System.out.println(" Delete error for key " + key + ": " + e.getMessage());
        }
    }
}
