import java.util.Arrays;
import java.util.List;
import java.util.Random;

public class RealSubscriberService implements SubscriberService {
	
	Random random = new Random();


	@Override
	public List<String> getSubscribersThatWillExpireBetweenNowAndDate(int day, int month, int year) {
		if(random.nextBoolean()) {
			return null;
		} else {
			String[] strings = {"mysterious email" + random.nextInt()};
			return Arrays.asList(strings);
		}
	}
}
