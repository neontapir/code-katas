class Diamond:
    def __init__(self, spec):
        if len(spec) != 1 or not spec.isupper():
            raise ValueError("spec must be a single uppercase letter")
        self.spec: str = spec
        self.diamond_array: list[str] = self._create()

    # NOTE: The idea behind _create is to create a block of strings that
    #   contains the shape I want.
    # For example, for a spec of "C", I'd start with:
    #   CBABC
    #   CBABC
    #   CBABC
    #   CBABC
    #   CBABC
    # Then, if I mask all but A,B,C,B,A with spaces, I get:
    #     A
    #    B B
    #   C   C
    #    B B
    #     A
    # The first step is accomplished by letters; the second, by make_line.
    # However, we have to erase the letters in the opposite order as the
    #   generated line in letters, hence masking_sequence.

    def _create(self) -> list[str]:
        def mirrored_seq(seq: str) -> str:
            """from 'C' to 'CBABC'"""
            return seq + seq[-2::-1]

        # Create template as a string 'CBA'
        template: str = "".join(chr(i) for i in range(ord(self.spec), ord("A") - 1, -1))
        diamond_template: str = mirrored_seq(template)

        unmasked_letters: str = template[::-1]
        masking_sequence: str = mirrored_seq(unmasked_letters)

        def make_line(letter: str) -> str:
            return "".join(" " if c != letter else c for c in diamond_template)

        return [make_line(x) for x in masking_sequence]

    def print(self):
        print("\n".join(self.diamond_array))
