import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.*;

public class Main {

    public static final int THREADS = 5;
    public static final int COUNT = 2;
    public static final double NSEC = 1000_000_000.0;

    public static MySemaphore mySemaphore = new MySemaphore(COUNT);
    public static Semaphore regularSemaphore = new Semaphore(COUNT);

    public static void main(String[] args) {
        
        System.out.println("---------------------------");
        System.out.println("|    Regular semaphore    |");
        System.out.println("---------------------------");
        double rsTime = runTask(regularSemaphore, true);

        System.out.println("---------------------------");
        System.out.println("|      My semaphore       |");
        System.out.println("---------------------------");
        double msTime = runTask(mySemaphore, false);

        System.out.println("======================================================");
        System.out.println(String.format("Время работы стандартного семафора: %.3f сек.", rsTime));
        System.out.println(String.format("Время работы пользовательского семафора: %.3f сек.", msTime));

        return;
    }

    private static double runTask(Semaphore semaphore, boolean printing) {
        ExecutorService es = Executors.newFixedThreadPool(THREADS);

        List<Callable<String>> tasks = new ArrayList<>();
        List<Future<String>> results = new ArrayList<>();

        for (int i = 0; i < THREADS; i++) {

            tasks.add(() -> {

                String threadName = Thread.currentThread().getName();

                if (printing) {

                    System.out.println("Поток " + threadName + " ожидает семафор. Свободные места: " + semaphore.availablePermits());
                    semaphore.acquire();
                    System.out.println(
                            "Поток " + threadName + " занял семафор. Свободные места: " + semaphore.availablePermits());
                    
                    Thread.sleep(1000);

                    System.out.println("Поток " + threadName + " завершил задачу. Свободные места: " + semaphore.availablePermits());
                    semaphore.release();
                    System.out.println("Поток " + threadName + " освободил семафор. Свободные места: " + semaphore.availablePermits());
                }
                else {
                    semaphore.acquire();
                    Thread.sleep(1000);
                    System.out.println("Поток " + threadName + " завершил задачу. Свободные места: " + semaphore.availablePermits());
                    semaphore.release();
                }

                return "Thread " + threadName + " done";
            });
        }

        long start = System.nanoTime();
        // invoke all the tasks
        try {
            results = es.invokeAll(tasks);
        } catch (InterruptedException ie) {
            ie.printStackTrace();
        }
        long finish = System.nanoTime();

        // shutdown executor service
        es.shutdown();

        return (finish - start) / NSEC;
    }
}