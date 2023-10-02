


# Env

```bash

export JAVA_HOME="/usr/lib/jvm/java-17-openjdk/"


```

# Eclipse 

```bash

# eclipse.ini

-vm
/usr/lib/jvm/java-17-openjdk/bin/java

```

# Gradle

```bash

export PATH=$PATH:/optd/opt/gradle-8.3/bin/

gradle tasks        #列出所有任务

gradle [taskName]   #执行任务

# 配置 -Ptests 才会测试默认不开启测试
test.onlyIf { project.hasProperty('tests') }

# 指定项目指定测试文件 -i 输出信息 -Ptests 是因为默认不开启测试
gradle :PROJECT:test --tests PATH.FILE -i -Ptests


# 设置main文件和引用jar目录
jar {
	manifest {
		attributes (
			'Class-Path': configurations.runtimeClasspath.collect {  "libs/${it.name}" }.join(' '),
			'Main-Class': "Path.AppMain"
		)		
	}
}


# 复制依赖jar到build/libs/libs
task copyJars(type: Copy) {
  	from configurations.runtimeClasspath
    into 'build/libs/libs'
}

```


# 编译单个文件

```bash

javac -classpath .;C:\path\lib1.jar;C:\path\lib1.jar -d . C:\path\file.java

```