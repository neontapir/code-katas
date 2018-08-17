import org.junit.Test;

public class RenewalNotificationServiceTest {

    @Test
    public void notifyingAtRiskSubscribersShouldSendEmails() {
        RenewalNotificationService renewalNotificationService = new RenewalNotificationService(new RealSubscriberService(), null);
        renewalNotificationService.notifyAtRiskSubscribers();
//		Uh oh... how will we know what happened if the method doesn't return any information?
    }
}
