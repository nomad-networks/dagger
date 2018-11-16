const dagger = require("./dagger");

test("parses an integer", () => {
    expect(dagger.parse("234").value).toBe(234);
});

test("parses a number with a fraction", () => {
    expect(dagger.parse("567.891").value).toBe(567.891);
});

test("parses a number with a label", () => {
    expect(dagger.parse("pi:3.14")).toEqual({label:"pi", value:3.14});
});
