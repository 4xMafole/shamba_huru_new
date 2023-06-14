import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';


export const getFeedModule = function(req: functions.https.Request, res: functions.Response<any>) {
    const uid = String(req.body.uid);
    
    async function compileFeedPost() {
      const following = await getFollowing(uid, res) as any;
  
      let listOfPosts = await getAllPosts(following, uid, res);
  
      listOfPosts = [].concat.apply([...listOfPosts]); // flattens list
      console.log('getFeedModule:', listOfPosts.length)
      res.send(listOfPosts);
    }
    
    compileFeedPost().then().catch();
}
  
async function getAllPosts(following: { [x: string]: any; }, uid: string, res: functions.Response<any>) {
    const listOfPosts = [];
  
    for (const user in following){
        listOfPosts.push( await getUserPosts(following[user], res));
    }

    // add the current user's posts to the feed so that your own posts appear in your feed
    listOfPosts.push( await getUserPosts(uid, res));
    console.log('getAllPosts ', listOfPosts.length)
    return listOfPosts; 
}
  
function getUserPosts(userId: any, res: any){
    const posts = admin.firestore().collection("posts").where("ownerId", "==", userId).orderBy("timestamp")
    console.log('posts ordered: ', posts)
    return posts.get()
    .then(function(querySnapshot) {
        const listOfPosts: any[] | PromiseLike<any[]> = [];
  
        querySnapshot.forEach(function(doc) {
            listOfPosts.push(doc.data());
        });
        console.log('listOFPosts: ', listOfPosts.length)
        return listOfPosts;
    })
}
  
  
function getFollowing(uid: string, res: functions.Response<any>){
    const doc = admin.firestore().doc(`users/${uid}`)
    return doc.get().then(snapshot => {
      const data = snapshot.data()
      if(data){

        const followings = data.following;
        
        const following_list = [];
    
        for (const following in followings) {
          if (followings[following] === true){
            following_list.push(following);
          }
        }
        return following_list; 
      }
      else {
        return [];
      }
  }).catch(error => {
      res.status(500).send(error)
    })
}
