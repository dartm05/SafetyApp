import {
  DocumentData,
  FirestoreDataConverter,
  QueryDocumentSnapshot,
} from "firebase/firestore";
import { ITask } from "../../domain/models/task/task";

export const taskConverter: FirestoreDataConverter<ITask> = {
  toFirestore(task: ITask): DocumentData {
    return task;
  },
  fromFirestore(snapshot: QueryDocumentSnapshot<ITask>): ITask {
    const data = snapshot.data();
    return {
      ...data,
      id: snapshot.id,
    };
  },
};
 
