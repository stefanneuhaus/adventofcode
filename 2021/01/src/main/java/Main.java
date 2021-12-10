import java.net.URI;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public class Main {

    public static void main(String[] args) throws Exception {
        List<Integer> measurements = getMeasurements();

        System.out.println(numberOfIncreasesSmoothed(measurements, 1));
        System.out.println(numberOfIncreasesSmoothed(measurements, 3));
    }


    private static int numberOfIncreasesSmoothed(List<Integer> measurements, int slidingWindowSize) {
        Stream<Integer> slidingWindowSums = getSlidingWindowSums(measurements, slidingWindowSize);

        int numberOfIncreases = 0;
        int previous = Integer.MAX_VALUE;
        for (int current : slidingWindowSums.toList()) {
            if (current > previous) {
                numberOfIncreases++;
            }
            previous = current;
        }

        return numberOfIncreases;
    }

    private static Stream<Integer> getSlidingWindowSums(List<Integer> measurements, int slidingWindowSize) {
        return IntStream.range(0, measurements.size() - slidingWindowSize + 1)
                .mapToObj(startIndex -> measurements.subList(startIndex, startIndex + slidingWindowSize))
                .map(list -> list.stream().mapToInt(Integer::valueOf))
                .map(IntStream::sum);
    }

    private static List<Integer> getMeasurements() throws Exception {
        URL resource = Main.class.getClassLoader().getResource("sonar-report.txt");
        URI uri = resource.toURI();
        Path path = Path.of(uri);
        return Files.lines(path)
                .map(Integer::parseInt)
                .toList();
    }

}
