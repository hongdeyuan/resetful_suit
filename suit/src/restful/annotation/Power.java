package restful.annotation;
import java.lang.annotation.RetentionPolicy;
@java.lang.annotation.Retention(value=RetentionPolicy.RUNTIME)
public @interface Power{
    public int value() default 0;
}