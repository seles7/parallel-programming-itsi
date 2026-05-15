import java.util.*;
import java.util.concurrent.*;

public class lab4 {
    public static final int THREADS = 40;
    public static final int ITERATIONS = 100_000;
    public static final double NSEC = 1000_000_000.0;
    public static final int MAP_SIZE = 100;
    public static final int SAMPLES = 5;

    public static Map<String, Integer> hashMap = new HashMap<>();
    public static Map<String, Integer> hashTable = new Hashtable<>();
    public static Map<String, Integer> syncMap = Collections.synchronizedMap(new HashMap<>());
    public static Map<String, Integer> cHashMap = new ConcurrentHashMap<>();

    public static void main(String[] args) {

        for(int i = 1; i <= 3; i++)
        {
            System.out.println("============================================================================");
            System.out.println("----------\n| Test " + i + " |\n----------");

            System.out.println("Collections:");

            double hashMapTime = compute(hashMap, i) / NSEC;
            double hashTableTime = compute(hashTable, i) / NSEC;
            double syncMapTime = compute(syncMap, i) / NSEC;
            double cHashMapTime = compute(cHashMap, i) / NSEC;

            System.out.println("\nExecution times:");
            System.out.println(String.format(
                    "\tHashMap: %.3f s,\n\tHashTable: %.3f s,\n\tSynchronizedMap: %.3f s,\n\tConcurrentHashMap: %.3f s.",
                    hashMapTime, hashTableTime, syncMapTime, cHashMapTime));

            if (i == 2) {

                long hashMapSum = mapSum(hashMap);
                long hashTableSum = mapSum(hashTable);
                long syncMapSum = mapSum(syncMap);
                long cHashMapSum = mapSum(cHashMap);

                System.out.println("\nValues sums (expected value = " + THREADS * MAP_SIZE + "):");
                System.out.println(String.format(
                        "\tHashMap: %d,\n\tHashTable: %d,\n\tSyncMap: %d,\n\tConcurrentHashMap: %d.",
                        hashMapSum, hashTableSum, syncMapSum, cHashMapSum));
            }
        }
        System.out.println("============================================================================");

        return;
    }

    private static long compute(Map<String, Integer> map, int mode) 
    {
        map.clear();

        System.out.print(String.format(" c\t%s ", map.getClass().getName()));

        long start = System.nanoTime();

        for (int k = 0; k < SAMPLES; k++) 
        {
            ExecutorService executorService = Executors.newFixedThreadPool(THREADS);

            List<Callable<String>> tasks = new ArrayList<>();
            List<Future<String>> results = new ArrayList<>();

            // create a list of tasks
            for (int i = 0; i < THREADS; i++) {

                tasks.add(() -> {
                    String threadName = Thread.currentThread().getName();

                    switch (mode) {
                        case 1:
                            excepting_func(map);
                            break;
                        case 2:
                            dataloss_func(map, threadName);
                            break;
                        case 3:
                            workingtime_func(map);
                            break;
                    }

                    return "Thread " + threadName + " done";
                });
            }

            // invoke all the tasks
            try {
                results = executorService.invokeAll(tasks);
            } catch (InterruptedException ie) {
                ie.printStackTrace();
            }
            // get results from futures
            try {
                for (Future<String> result : results) {
                    String s = result.get();
                    // System.out.println(s);
                }
            } catch (InterruptedException | ExecutionException e) {
                e.printStackTrace();
            }

            // shutdown executor service
            executorService.shutdown();
            if(mode == 2)
                break;
        }
        
        long stop = System.nanoTime();

        System.out.println(" ...done.");

        return (stop - start) / SAMPLES;
    }

    private static void excepting_func(Map<String, Integer> map) {

        for (int j = 0; j < ITERATIONS; j++) {

            Integer num = (int) ThreadLocalRandom.current().nextInt(1, MAP_SIZE + 1);
            String key = String.valueOf(num);

            map.merge(key, 1, Integer::sum);
        }
        return;
    }

    private static void workingtime_func(Map<String, Integer> map) {

        for (int j = 0; j < ITERATIONS; j++) {

            Integer num = (int) ThreadLocalRandom.current().nextInt(1, MAP_SIZE + 1);
            String key = String.valueOf(num);

            Integer value = map.get(key);

            map.put(key, value == null ? num : (value + num) % MAP_SIZE);
        }
        return;
    }
    
    private static void dataloss_func(Map<String, Integer> map, String threadname) {

        for (int j = 0; j < MAP_SIZE; j++) {

            String key = threadname + "key" + j;

            map.put(key, 1);
        }
        return;
    }

    private static long mapSum(Map<String, Integer> map) {

        long sum = 0;

        for (Integer value : map.values()) {

            if (value != null)
            sum += value;
        }
        return sum;
    }
}
