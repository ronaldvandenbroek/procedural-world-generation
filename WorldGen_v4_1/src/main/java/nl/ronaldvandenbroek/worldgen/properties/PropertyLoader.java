package nl.ronaldvandenbroek.worldgen.properties;

import java.io.FileInputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.net.URL;
import java.nio.file.Paths;
import java.util.Properties;

public class PropertyLoader {
    public static void load(Class<?> configClass, String fileName) {
        try {
            URL resource = PropertyLoader.class.getResource("/" + fileName);
            String filePath = Paths.get(resource.toURI()).toFile().getAbsolutePath();

            Properties props = new Properties();
            try (FileInputStream propStream = new FileInputStream(filePath)) {
                props.load(propStream);
            }
            for (Field field : configClass.getDeclaredFields())
                if (Modifier.isStatic(field.getModifiers()))
                    field.set(null, getValue(props, field.getName(), field.getType()));
        } catch (Exception e) {
            throw new RuntimeException("Error loading configuration: " + e, e);
        }
    }
    private static Object getValue(Properties props, String name, Class<?> type) {
        String value = props.getProperty(name);
        if (value == null)
            throw new IllegalArgumentException("Missing configuration value: " + name);
        if (type == String.class)
            return value;
        if (type == boolean.class)
            return Boolean.parseBoolean(value);
        if (type == int.class)
            return Integer.parseInt(value);
        if (type == float.class)
            return Float.parseFloat(value);
        throw new IllegalArgumentException("Unknown configuration value type: " + type.getName());
    }
}
