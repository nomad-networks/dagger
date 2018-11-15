const dagger = require("./dagger");

test("parses an integer", () => {
    expect(dagger.parse("234").value).toBe(234);
});

test("parses a number with a fraction", () => {
    expect(dagger.parse("567.891").value).toBe(567.891);
});