import { ITask } from '../../../src/domain/models/task/task';   

import { describe, it, beforeEach, expect } from "@jest/globals";

describe("ITask", () => {
    let task: ITask;

    beforeEach(() => {
        task = {
            id: "1",
            title: "Test Task",
            description: "This is a test task",
            done: false,
            createdAt: new Date(),
        };
    });

    it("should have an id property of type string", () => {
        expect(typeof task.id).toBe("string");
    });

    it("should have a title property of type string", () => {
        expect(typeof task.title).toBe("string");
    });

    it("should have a description property of type string", () => {
        expect(typeof task.description).toBe("string");
    });

    it("should have a done property of type boolean", () => {
        expect(typeof task.done).toBe("boolean");
    });

    it("should have a createdAt property of type Date", () => {
        expect(task.createdAt).toBeInstanceOf(Date);
    });
});