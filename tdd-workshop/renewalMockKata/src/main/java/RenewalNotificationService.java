public class RenewalNotificationService {

    SubscriberService myThing;

    public RenewalNotificationService(SubscriberService subscriberService, EmailService emailService) {
        myThing = subscriberService;
    }

    public void notifyAtRiskSubscribers() {
    }
}
