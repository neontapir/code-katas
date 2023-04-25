class Game:
    def __init__(self):
        self.frames = []

    def get(self, place: int) -> int:
        return self.frames[place] if place < len(self.frames) else 0

    def score(self) -> int:
        i = 0
        total = 0
        for f in range(10):
            total += self.get(i) + self.get(i+1)
            print(f'Roll: {total}')
            if (self.get(i) == 10):
                total += self.get(i+2)
                print(f'Strike: {total}')
                i += 1
            else: 
                if (self.get(i) + self.get(i+1) == 10):
                    total += self.get(i+2)
                    print(f'Spare: {total}')
                i += 2
        return total
    
    def roll(self, value: int):
        self.frames.append(value)

    