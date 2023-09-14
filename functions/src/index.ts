import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();
const region = functions.region('asia-northeast3');
const firestore = admin.firestore();
const storage = admin.storage();

export const onVideoCreated = region.firestore
  .document('videos/{videoId}')
  .onCreate(async (snapshot, context) => {
    const spawn = require('child-process-promise').spawn;
    const video = snapshot.data();
    await spawn('ffmpeg', [
      '-i',
      video.fileUrl,
      '-ss',
      '00:00:00',
      '-vframes',
      '1',
      '-vf',
      'scale=150:-1', // scale down
      `/tmp/${snapshot.id}.jpg`, // save tmp
    ]);
    const [file] = await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`, {
      destination: `thumbnails/${snapshot.id}.jpg`,
    });
    await file.makePublic();
    await snapshot.ref.update({ thumbnailUrl: file.publicUrl() });

    // denomalization
    await firestore
      .collection('users')
      .doc(video.creatorUid)
      .collection('videos')
      .doc(snapshot.id)
      .set({
        videoId: snapshot.id,
        thumbnailUrl: file.publicUrl(),
      });
  });
