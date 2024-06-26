class Diamond:
    def __init__(self, spec):
        if len(spec) != 1 or not spec.isupper():
            raise ValueError("spec must be a single uppercase letter")
        self.spec: str = spec
        self.diamond_array: list[str] = self._create()

    def _create(self) -> list[str]:
        if self.spec == "A":
            return ["A"]

        letters: list[str] = [chr(i) for i in range(ord("A"), ord(self.spec) + 1)]
        width: int = 2 * len(letters) - 1

        def make_line(i, letter) -> str:
            if i == 0:  # For 'A'
                return letter.center(width)
            outer_spaces: int = width // 2 - i
            inner_spaces: int = width - 2 * outer_spaces - 2
            return f"{' ' * outer_spaces}{letter}{' ' * inner_spaces}{letter}{' ' * outer_spaces}"

        top_half: list[str] = [make_line(i, letter) for i, letter in enumerate(letters)]
        bottom_half: list[str] = top_half[-2::-1]

        return top_half + bottom_half

    def print(self):
        print("\n".join(self.diamond_array))
