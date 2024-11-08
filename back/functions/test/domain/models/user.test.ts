import { IUser } from "../../../src/domain/models/user/user";
import { describe, it, expect } from "@jest/globals";

describe("IUser Interface", () => {
  it("should create a valid user object", () => {
    const user: IUser = {
      id: "1",
      name: "Maria",
      email: "mariab@example.com",
    };

    expect(user.id).toBe("1");
    expect(user.name).toBe("Maria");
    expect(user.email).toBe("mariab@example.com");
  });

  it("should allow additional properties but still conform to IUser", () => {
    const user: IUser & { age?: number } = {
      id: "3",
      name: "Alice",
      email: "alice@example.com",
      age: 30,
    };

    expect(user.id).toBe("3");
    expect(user.name).toBe("Alice");
    expect(user.email).toBe("alice@example.com");
    expect(user.age).toBe(30);
  });
});
