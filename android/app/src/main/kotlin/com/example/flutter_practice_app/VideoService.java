// VideoService.java
package com.example.flutter_practice_app;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import androidx.core.app.NotificationCompat;

public class VideoService extends Service {
    private static final String CHANNEL_ID = "VideoServiceChannel";

    @Override
    public void onCreate() {
        super.onCreate();
        createNotificationChannel();
        startForeground(1, getNotification());
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        // TODO: Play video in the background
        return START_NOT_STICKY;
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    private Notification getNotification() {
        Intent notificationIntent = new Intent(this, MainActivity.class);
        // PendingIntent pendingIntent = PendingIntent.getActivity(this,
        //         0, notificationIntent, 0);

        PendingIntent pendingIntent = PendingIntent.getActivity(this, 
        0, notificationIntent, PendingIntent.FLAG_IMMUTABLE);

        return new NotificationCompat.Builder(this, CHANNEL_ID)
                .setContentTitle("Video Service")
                .setContentText("Playing video in the background")
                .setSmallIcon(R.drawable.ic_notification)
                .setContentIntent(pendingIntent)
                .build();
    }

    private void createNotificationChannel() {
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            NotificationChannel serviceChannel = new NotificationChannel(
                    CHANNEL_ID,
                    "Video Service Channel",
                    NotificationManager.IMPORTANCE_DEFAULT
            );
            NotificationManager manager = getSystemService(NotificationManager.class);
            manager.createNotificationChannel(serviceChannel);
        }
    }
}
