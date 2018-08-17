import java.util.Date;
import java.util.List;

public interface SubscriberService {
	
	public List<String> getSubscribersThatWillExpireBetweenNowAndDate(int day, int month, int year);

}
